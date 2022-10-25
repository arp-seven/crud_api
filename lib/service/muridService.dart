import 'package:crud_api/model/model.dart';
import 'package:http/http.dart' as http;

class MuridService {
  static final String _baseUrl = 'https://app-sekolah.herokuapp.com/api/murid';

  Future getMurid() async {
    Uri urlApi = Uri.parse(_baseUrl);
    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      return muridFromJson(response.body.toString());
    } else {
      throw Exception("Gagal Mengambil Data Murid");
    }
  }

  Future saveMurid(String nisn, String name, String email, String telpon,
      String address, String gender, String kelas) async {
    Uri urlApi = Uri.parse(_baseUrl);
    final response = await http.post(urlApi,
        body: ({
          "nisn": nisn,
          "name_murid": name,
          "email_murid": email,
          "number_phone_murid": telpon,
          "address": address,
          "gender": gender,
          "kelas_id": kelas,
        }));
    if (response.statusCode == 200) {
      print("Data Berhasil Disimpan");
      return true;
    } else {
      print("Data Gagal Disimpan");
      return false;
    }
  }
}
