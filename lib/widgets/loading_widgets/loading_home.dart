import 'package:animations_anatomy/screens/loading_screen1.dart';
import 'package:flutter/material.dart';

enum DataStatus { initial, start, end }

class LoadingHome extends StatefulWidget {
  const LoadingHome(
      {Key? key, required this.progressAnimation, required this.onPressed})
      : super(key: key);
  final Animation<double> progressAnimation;
  final VoidCallback onPressed;
  @override
  State<LoadingHome> createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  DataStatus _currentStatus = DataStatus.initial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 3,
            child: Text(
              'Cloud Storage',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (_currentStatus == DataStatus.end)
            Expanded(
              flex: 2,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, double val, child) {
                  return Opacity(opacity: val, child: child);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('uploading files', textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FittedBox(
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: LoadingCounter(widget.progressAnimation)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_currentStatus != DataStatus.end)
            Expanded(
              flex: 2,
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                    begin: 1,
                    end: _currentStatus == DataStatus.initial ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 500),
                onEnd: () => setState(() => _currentStatus = DataStatus.end),
                builder: (context, double val, child) {
                  return Opacity(
                    opacity: val,
                    child: Transform.translate(
                        offset: Offset(0, 50 * val), child: child!),
                  );
                },
                child: Column(
                  children: const [
                    Text('last backup:'),
                    SizedBox(height: 10),
                    Text(
                      '30th June 2022',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainDataBackupColor),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _currentStatus == DataStatus.initial
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: mainDataBackupColor,
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            _currentStatus = DataStatus.start;
                          });
                          widget.onPressed();
                        },
                        child: const Text('Create Backup'),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStatus = DataStatus.initial;
                        });
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: secondaryDataBackupColor),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingCounter extends AnimatedWidget {
  const LoadingCounter(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);
  double get value => (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    return Text('${(value * 100).truncate()}%',
        style: const TextStyle(fontSize: 20, color: mainDataBackupColor));
  }
}
