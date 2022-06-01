part of '../result_screen.dart';

class _DownloadJSON extends StatelessWidget {
  final String downloadURL;
  const _DownloadJSON({Key? key, required this.downloadURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Download Semua Paket Soal",
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 20),
        OutlinedButton.icon(
            onPressed: () {
              if (kIsWeb) {
                js.context.callMethod('open', [downloadURL]);
              }
            },
            icon: const Icon(
              Icons.download,
              color: Colors.black,
            ),
            label: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Download",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ))
      ],
    );
  }
}
