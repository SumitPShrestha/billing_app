abstract class BaseModel {
  late String _createdAt;
  late int _createdBy;
  late String _updatedAt;
  late int _updatedBy;

  BaseModel();

  Map<String, dynamic> toMap() {
    this.toMap()["createdAt"] = _createdAt;
    this.toMap()["createdBy"] = _createdBy;
    this.toMap()["updatedAt"] = _updatedAt;
    this.toMap()["updatedBy"] = _updatedBy;
    return this.toMap();
  }

  BaseModel.fromMap(BaseModel obj);
}
