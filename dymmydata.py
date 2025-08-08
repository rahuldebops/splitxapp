import random
from datetime import datetime, timedelta

# === Constants and setup === #
users = [
    1946634249591328768,
    1946969414930796544,
    1948059401554235392,
    1949359649887096832,
]
groups = [
    (1946950359440166912, "Ahaldara TripINR", [users[0], users[1], users[2]]),
    (1946950945329909760, "Europe TripEUR",   [users[0], users[2], users[3]]),
    (1953113793756139520, "Varanasi TripINR", [users[0], users[1], users[3]]),
    (1953113835682402304, "New York TripUSD", [users[0], users[1], users[2]]),
    (1953113878342668288, "Chicago TripINR",  [users[0], users[2], users[3]])
]
DESC_POOL = [
    "Dinner at restaurant", "Taxi", "Museum tickets", "Snacks", "Train fare", "Boat ride", "Hotel room",
    "Tour guide", "Lunch", "Coffee", "Souvenir shopping", "Entrance fee", "Park visit", "Breakfast",
    "Shopping groceries", "Drinks at club", "Bike rental", "City pass", "Day trip", "Ice cream"
]

# === Utility for SQL datetime string === #
def dt_str(days_ago):
    return (datetime.now() - timedelta(days=days_ago)).strftime("%Y-%m-%d %H:%M:%S")

# === Main script === #
with open("splitx_insert_dummy.sql", "w") as f:
    def p(x):
        f.write(x + "\n")

    # Insert group user memberships
    p("-- Insert group users")
    for group_id, group_name, member_ids in groups:
        for uid in member_ids:
            p(
                f"INSERT INTO app.group_users (group_id, user_id, is_active, created_by) VALUES ({group_id}, {uid}, true, 1946634249591328768);"
            )

    exp_id_base = 3000000000000000000
    split_id_base = 3100000000000000000
    exp_pay_id_base = 3200000000000000000
    ppay_id_base = 4000000000000000000
    days_shift = [i for i in range(25, 5, -1)]  # for varied created_at

    p("\n-- Insert expenses, splits, and payments")
    for gno, (group_id, group_name, member_ids) in enumerate(groups):
        expense_ids = []
        descs = random.sample(DESC_POOL, 20)
        for ei in range(20):
            eid = exp_id_base + gno * 1000 + ei
            expense_ids.append(eid)
            total = random.randint(400, 3200)
            desc = descs[ei]
            created_by = random.choice(member_ids)
            days_ago = random.choice(days_shift)
            p(
                f"INSERT INTO app.expenses (id, group_id, description, amount, created_by, updated_by, created_at, updated_at) "
                f"VALUES ({eid}, {group_id}, '{desc}', {total:.2f}, {created_by}, {created_by}, '{dt_str(days_ago)}', '{dt_str(days_ago)}');"
            )
            # Splits (even)
            split = round(total / 3, 2)
            for sidx, uid in enumerate(member_ids):
                splitid = split_id_base + gno * 1000 + ei * 3 + sidx
                p(
                    f"INSERT INTO app.expense_splits (id, expense_id, user_id, owed_amount, created_by, updated_by, created_at, updated_at) "
                    f"VALUES ({splitid}, {eid}, {uid}, {split:.2f}, {created_by}, {created_by}, '{dt_str(days_ago)}', '{dt_str(days_ago)}');"
                )
            # Payments toward expense -- randomly 1 or 2 payers
            pay_cases = [member_ids, member_ids[::-1]]
            pay_users = random.choice(pay_cases)[:random.choice([1,2])]
            pay_amts = []
            if len(pay_users) == 1:
                pay_amts = [total]
            else:
                part = random.randint(1, total - 1)
                pay_amts = [part, total - part]
            for pidx, puser in enumerate(pay_users):
                payid = exp_pay_id_base + gno * 1000 + ei * 2 + pidx
                p(
                    f"INSERT INTO app.expense_payments (id, expense_id, paid_by, amount, created_by, updated_by, created_at, updated_at) "
                    f"VALUES ({payid}, {eid}, {puser}, {pay_amts[pidx]:.2f}, {puser}, {puser}, '{dt_str(days_ago)}', '{dt_str(days_ago)}');"
                )

    p("\n-- Insert peer-to-peer payments (txn.payments), 10 per group")
    for gno, (group_id, group_name, member_ids) in enumerate(groups):
        used_pairs = []
        for j in range(10):
            from_user, to_user = random.sample(member_ids, 2)
            while (from_user, to_user) in used_pairs:
                from_user, to_user = random.sample(member_ids, 2)
            used_pairs.append((from_user, to_user))
            amt = random.randint(100, 600)
            created_by = from_user
            days_ago = random.choice(days_shift)
            payid = ppay_id_base + gno * 1000 + j
            p(
                f"INSERT INTO txn.payments (id, from_user, to_user, amount, group_id, paid_at, created_by, updated_by) "
                f"VALUES ({payid}, {from_user}, {to_user}, {amt:.2f}, {group_id}, '{dt_str(days_ago)}', {created_by}, {created_by});"
            )

print("Generated: splitx_insert_dummy.sql")
