import 'package:floor/floor.dart';

import '../model/lead.dart';

@dao
abstract class LeadDao {
  @Query('SELECT * FROM leads')
  Future<List<Lead>> getAllLeads();

  @Query('SELECT * FROM leads WHERE status = :status')
  Future<List<Lead>> getLeadsByStatus(String status);

  @Query('SELECT * FROM leads WHERE source = :source')
  Future<List<Lead>> getLeadsBySource(String source);

  @Query('SELECT * FROM leads WHERE status = :status AND source = :source')
  Future<List<Lead>> getLeadsByStatusAndSource(String status, String source);


  @insert
  Future<void> insertLead(Lead lead);

  @update
  Future<void> updateLead(Lead lead);

  @delete
  Future<void> deleteLead(Lead lead);
}