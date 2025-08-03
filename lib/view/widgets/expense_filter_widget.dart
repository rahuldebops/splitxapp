import 'package:flutter/material.dart';
import 'package:splitxapp/utils/colors.dart';

class ExpenseFilterWidget extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedMember;
  final DateTimeRange? dateRange;
  final Function(String?) onCategoryChanged;
  final Function(String?) onMemberChanged;
  final Function(DateTimeRange?) onDateRangeChanged;
  final VoidCallback onClearFilters;

  const ExpenseFilterWidget({
    super.key,
    this.selectedCategory,
    this.selectedMember,
    this.dateRange,
    required this.onCategoryChanged,
    required this.onMemberChanged,
    required this.onDateRangeChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final hasFilters = selectedCategory != null || 
                      selectedMember != null || 
                      dateRange != null;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (hasFilters)
                TextButton(
                  onPressed: onClearFilters,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: selectedCategory ?? 'Category',
                  isSelected: selectedCategory != null,
                  onTap: () => _showCategoryFilter(context),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: selectedMember ?? 'Member',
                  isSelected: selectedMember != null,
                  onTap: () => _showMemberFilter(context),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: dateRange != null ? 'Date Range' : 'Date',
                  isSelected: dateRange != null,
                  onTap: () => _showDateFilter(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? kPrimaryColor : kGrey.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : null,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isSelected ? Colors.white : kGrey,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryFilter(BuildContext context) {
    final categories = ['Food', 'Transport', 'Accommodation', 'Entertainment', 'Shopping', 'Other'];
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Category',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...categories.map((category) => ListTile(
              title: Text(category),
              trailing: selectedCategory == category ? 
                Icon(Icons.check, color: kPrimaryColor) : null,
              onTap: () {
                onCategoryChanged(selectedCategory == category ? null : category);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showMemberFilter(BuildContext context) {
    final members = ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson'];
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Member',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...members.map((member) => ListTile(
              title: Text(member),
              trailing: selectedMember == member ? 
                Icon(Icons.check, color: kPrimaryColor) : null,
              onTap: () {
                onMemberChanged(selectedMember == member ? null : member);
                Navigator.pop(context);
              },
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDateFilter(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: dateRange,
    );
    
    if (picked != null) {
      onDateRangeChanged(picked);
    }
  }
}
