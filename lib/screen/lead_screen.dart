

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth_controller.dart';
import '../controller/lead_controller.dart';
import '../model/lead.dart';


class LeadScreen extends StatelessWidget {
  final controller = Get.put(LeadController());
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  RxString selectedStatus = "".obs;
  RxString selectedSource=  "".obs;

  final List<String> statuses = ['All', 'New', 'Contacted', 'Converted', 'Lost'];
  final List<String> sources = ['All', 'Website', 'Referral', 'Social Media'];


  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  String source = 'Website';
  String status = 'New';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Lead Manager'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: ElevatedButton.icon(
              onPressed: () => authController.logout(),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red[700],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.red[200]!),
                ),
              ),
            ),
          ),

        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: selectedStatus.value.isEmpty ? null : selectedStatus.value,
                          hint: const Text("Status"),
                          underline: SizedBox(),
                          items: statuses.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedStatus.value = value ?? "";
                            controller.filterByStatusAndSource(selectedStatus.value, selectedSource.value);
                          },
                        ),
                      )),
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSource.value.isEmpty ? null : selectedSource.value,
                          hint: const Text("Source"),
                          underline: SizedBox(),
                          items: sources.map((String source) {
                            return DropdownMenuItem<String>(
                              value: source,
                              child: Text(source),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedSource.value = value ?? "";
                            controller.filterByStatusAndSource(selectedStatus.value, selectedSource.value);
                          },
                        ),
                      )),
                    ],
                  ),


                  SizedBox(height: 10,),
                  Card(
                    elevation: 6,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Title
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.person_add, color: Theme.of(context).primaryColor, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Add New Lead',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            /// Name
                            TextFormField(
                              controller: nameCtrl,
                              decoration: _inputDecoration(context, 'Name', Icons.person_outline),
                              validator: (val) => val!.isEmpty ? 'Required Name' : null,
                            ),
                            const SizedBox(height: 16),

                            /// Email
                            TextFormField(
                              controller: emailCtrl,
                              decoration: _inputDecoration(context, 'Email', Icons.email_outlined),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Email is required';
                                }

                                final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

                                if (!emailRegExp.hasMatch(val.trim())) {
                                  return 'Enter a valid email';
                                }

                                return null;
                              },

                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: phoneCtrl,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: _inputDecoration(context, 'Phone', Icons.phone_outlined),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Phone number is required';
                                }

                                final trimmed = val.trim();

                                if (!RegExp(r'^[0-9]{10}$').hasMatch(trimmed)) {
                                  return 'Enter a valid 10-digit phone number';
                                }

                                return null;
                              },

                            ),
                            const SizedBox(height: 16),

                            DropdownButtonFormField<String>(
                              value: source,
                              decoration: _inputDecoration(context, 'Source', Icons.source_outlined),
                              items: ['Website', 'Referral', 'Social Media']
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (val) => source = val!,
                            ),
                            const SizedBox(height: 24),


                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.addLead(Lead(
                                      name: nameCtrl.text,
                                      email: emailCtrl.text,
                                      phone: phoneCtrl.text,
                                      source: source,
                                      status: status,
                                    ));
                                    nameCtrl.clear();
                                    emailCtrl.clear();
                                    phoneCtrl.clear();
                                  }
                                },
                                icon: const Icon(Icons.add, size: 20),
                                label: const Text('Add Lead'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'All Leads',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),

                  Obx(() => ListView.builder(
                    itemCount: controller.leads.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      final lead = controller.leads[i];
                      return _buildLeadCard(context, lead);
                    },
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );


  }


  InputDecoration _inputDecoration(BuildContext context, String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[50],
    );
  }



  Widget _buildLeadCard(BuildContext context, Lead lead) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              lead.name[0].toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(lead.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lead.email, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(lead.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getStatusColor(lead.status).withOpacity(0.3)),
                ),
                child: Text(
                  lead.status,
                  style: TextStyle(
                    color: _getStatusColor(lead.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: lead.status,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(8),
                items: ['New', 'Contacted', 'Converted', 'Lost']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 14))))
                    .toList(),
                onChanged: (val) => controller.updateLeadStatus(lead, val!),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red[600], size: 20),
                onPressed: () => controller.deleteLead(lead),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Contacted':
        return Colors.orange;
      case 'Converted':
        return Colors.green;
      case 'Lost':
        return Colors.red;
      default:
        return Colors.grey;
    }



  }
  }