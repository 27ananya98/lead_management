import 'package:get/get.dart';
import '../db/lead_database.dart';
import '../db/lead_dao.dart';
import '../model/lead.dart';

class LeadController extends GetxController {
  late LeadDatabase database;
  late LeadDao leadDao;
  var leads = <Lead>[].obs;

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  Future<void> initDb() async {
    database = await $FloorLeadDatabase.databaseBuilder('lead_db.db').build();

    leadDao = database.leadDao;
    fetchLeads();
  }

  Future<void> fetchLeads() async {
    final result = await leadDao.getAllLeads();
    leads.assignAll(result);
  }

  Future<void> addLead(Lead lead) async {
    await leadDao.insertLead(lead);
    fetchLeads();
  }

  Future<void> updateLeadStatus(Lead lead, String status) async {
    await leadDao.updateLead(lead.copyWith(status: status));
    fetchLeads();
  }

  Future<void> deleteLead(Lead lead) async {
    await leadDao.deleteLead(lead);
    fetchLeads();
  }

  Future<void> filterByStatus(String status) async {
    if (status.isEmpty) {
      await fetchLeads();
    } else {
      leads.value = await leadDao.getLeadsByStatus(status);
    }
  }

  Future<void> filterBySource(String source) async {
    if (source.isEmpty) {
      await fetchLeads();
    } else {
      leads.value = await leadDao.getLeadsBySource(source);
    }
  }

  Future<void> filterByStatusAndSource(String status, String source) async {
    if (status .isEmpty && source .isEmpty) {
      await fetchLeads();
    } else if (status .isNotEmpty && source.isEmpty) {
      await filterByStatus(status);
    } else if (status .isEmpty && source.isNotEmpty) {
      await filterBySource(source);
    } else {
      leads.value = await leadDao.getLeadsByStatusAndSource(status, source);
    }
  }

}