class ProductModel{
  int? id;
  String? email, jumlah;

  ProductModel({
  this.id, this.email, this.jumlah
  });

  factory ProductModel.fromJson(Map<String, dynamic>json){
    return ProductModel(
      id : json['id'],
      email : json['email'],
      jumlah: json['jumlah']
    );
  }
}