import 'dart:convert';
import 'package:jose/jose.dart';

class JwtGenerator {
  final String privateKeyPem;
  final String publicKeyPem;

  JwtGenerator({
    required this.privateKeyPem,
    required this.publicKeyPem,
  });

  Future<String> generateToken({
    int? empId,
    String? empEmail,
    Duration expiration = const Duration(minutes: 5),
  }) async {
    try {
      // Create specific payload structure
      final now = DateTime.now();
      final exp = now.add(expiration);

      final Map<String, dynamic> payload = {
        'exp': exp.millisecondsSinceEpoch ~/ 1000,
        if (empEmail != null) 'EmpEmail': empEmail,
        if (empId != null) 'EmpID': empId,
        'iat': now.millisecondsSinceEpoch ~/ 1000,
      };
      print(payload);
      // Create JWT with specific header
      final jwk = JsonWebKey.fromPem(privateKeyPem);

      final builder = JsonWebSignatureBuilder()
        ..jsonContent = payload
        ..setProtectedHeader('typ', 'JWT')
        ..setProtectedHeader('alg', 'RS256')
        ..addRecipient(jwk, algorithm: 'RS256');

      final jws = builder.build();
      return jws.toCompactSerialization();
    } catch (e) {
      throw Exception('Token generation failed: $e');
    }
  }

  Future<Map<String, dynamic>> verifyToken(String token) async {
    try {
      final jwk = JsonWebKey.fromPem(publicKeyPem);
      final jws = JsonWebSignature.fromCompactSerialization(token);

      final payload = await jws.verify(JsonWebKeyStore()..addKey(jwk));

      if (!payload) {
        throw Exception('Invalid signature');
      }

      return jws.toJson();
    } catch (e) {
      throw Exception('Token verification failed: $e');
    }
  }
}

Future<String> jwtBuilderFunction({
  int? empId,
  String? empEmail,
}) async {
  try {
    // Initialize JWT generator
    final jwtGenerator = JwtGenerator(
      privateKeyPem: privateKey,
      publicKeyPem: publicKey,
    );

    // Generate token with specific EmpID

    final token = await jwtGenerator.generateToken(
      // empId: 'abdulmajida@sedco.com',
      empEmail: empEmail,
      empId: empId,
      expiration: const Duration(days: 10),
    );

    // Print token parts

    printTokenParts(token);

    // Verify token

    final decodedPayload = await jwtGenerator.verifyToken(token);
    return token;
  } catch (e) {
    return '';
  }
}

void printTokenParts(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    return;
  }
}

String _decodeTokenPart(String part) {
  final normalized = base64Url.normalize(part);
  final decoded = utf8.decode(base64Url.decode(normalized));
  return const JsonEncoder.withIndent('  ').convert(json.decode(decoded));
}

const String privateKey = '''
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAt8y75k91hQJ+8/BBSUdT6rGJNaOropemdA8G/qMvj0C4YiXv
rD1QIit2wrIJEmoM+qOCmAnUx5JJZOk79XtJkjQhbwCL/dOn9SsBUcGx5nckznJA
jJVi18benoIYvhyf9B8r16eXaAG8C5i4Fked1gQNtvm+C9cTSjlTAalZFSpYzXSm
BK8wdsw41G4laiphDMRZQkQ5MPb9fed2/ZNPpYtZ7iW4rsPW5cUlHznTLUoxRjzA
+Yx4uXjHhtSFtVpXOYl+RPz4n3x4cHZaW1FpKK3pSuxdh2D9F9YxyBDBBtFA11x+
yrLfSGeHrdQ59noXMZD0nDpMNCke3JfemqrilQIDAQABAoIBAQCMXQTuGKZ14ncT
Udp53MgARn6zgP+1Vrzeiw9bbUIH03Q8OB512gkVXz3957q33ld1HWPBOljN5DC6
qMeKbBG+XqNdwvwl5vqwZ5xFVHfIuhpYsrYK5paqlIw0XsQIg5G//AIeWjVtT03N
SV7kXOLzqvrSTp1NK33mxCpY7XxDhVyZJlMfjXwPKrkP21o62EWZKQT9+ed1yQsx
1KF8WpLB/vyrPuawZI8STUEh51bTpZtbmAXNw6mS0AISE0kn5/WpsD8Y/gS6GOna
m8H3WvdSUILPtx6kcVy7hbVzAmio5Co5Hr6MmSFb7IwiweLEqTrnffmIOq1KhTMS
sNdm4/jtAoGBAOXG3XBSToVlRGHwuOLAkolu4MYCilDU99Ob4twSOvjr4uxuSfot
KACT08rR2g3+BvWTP5n2sbFWqsOKreiLjERvDvCteobm7kd0owf06oGTzqnQkKak
kPMFDJhw+2MKhdmyR1JmKikiDBQhl5PqE/DN5tZ13pXO5T2qV0oxUv1vAoGBAMzG
m5D6vxfHcj4l26nM0Uazq6hJcfkt1NZR6hJ05vGs/Ul+bao0EcLGxHYd4leHk2Z+
yIru+wG0YXX2OIKUaTP0BJuR4zihx72FOeujq204KJ3ft5py6suB6IjZ1BDW+fth
fvk3K7yS8EwUOU5MS6LWn94BwRv9Cids9mgl1CY7AoGAHk5wfpQcjzOgJVrex+mm
akIZm4RSQf8VAPAap/Qvmw1hzNVvJHQ4Rns5ABNVs2rB+DoHtYL4RO+tbkUoUve0
9IHBcrUu6AQlgX880ZvYImcgZv1/Vrt18tfDpYehYJrOtLvy9EdNYEeBWFZl67iA
EM7Xl4nMZe34Bn4lLT/8NjkCgYEAlmOqLqCopQsaMOBW4e6FJ9qeT/qYlLr/G+OO
970ZOxaj8kzCt4SEIrsd3+10pHnyXAzytW5rs8XI6fxJZkUeukQU+jf7W0UdT2e/
sPpD1POwiLmbuvd4zrr6jz8DCtcHQoJI4TiOi3CSwBz+NS29QrtDL6W0MBz3Txss
IDLgCq8CgYBYRqy5faIK2fBnVvFueSyR8cRD6i6niMuoHwOmFkWdlQIvQQyjppwm
l2QSN9/v6Q90lRy2ebjSnhOFyeWW1h5I4UGi6JA+rZg80SDl2ADdy8v/EiJa+HkZ
lFU3/Os6XgsDFwlchhwarFqiARt3oHnyeQmgYIlAfZXXGquLUIQv5g==
-----END RSA PRIVATE KEY-----
''';

const String publicKey = '''
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt8y75k91hQJ+8/BBSUdT
6rGJNaOropemdA8G/qMvj0C4YiXvrD1QIit2wrIJEmoM+qOCmAnUx5JJZOk79XtJ
kjQhbwCL/dOn9SsBUcGx5nckznJAjJVi18benoIYvhyf9B8r16eXaAG8C5i4Fked
1gQNtvm+C9cTSjlTAalZFSpYzXSmBK8wdsw41G4laiphDMRZQkQ5MPb9fed2/ZNP
pYtZ7iW4rsPW5cUlHznTLUoxRjzA+Yx4uXjHhtSFtVpXOYl+RPz4n3x4cHZaW1Fp
KK3pSuxdh2D9F9YxyBDBBtFA11x+yrLfSGeHrdQ59noXMZD0nDpMNCke3Jfemqri
lQIDAQAB
-----END PUBLIC KEY-----
''';
