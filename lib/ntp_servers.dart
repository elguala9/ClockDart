/// NTP server addresses for time synchronization
class NtpServers {
  /// Google NTP servers
  static const google = 'time.google.com';
  static const google1 = 'time1.google.com';
  static const google2 = 'time2.google.com';
  static const google3 = 'time3.google.com';
  static const google4 = 'time4.google.com';

  /// Cloudflare NTP server
  static const cloudflare = 'time.cloudflare.com';

  /// NTP Pool Project servers
  static const pool0 = '0.pool.ntp.org';
  static const pool1 = '1.pool.ntp.org';
  static const pool2 = '2.pool.ntp.org';
  static const pool3 = '3.pool.ntp.org';

  /// NIST NTP servers
  static const nist1 = 'time.nist.gov';
  static const nist2 = 'time-a.nist.gov';
  static const nist3 = 'time-b.nist.gov';

  /// Default server (NTP Pool Project)
  static const defaultServer = pool0;

  /// List of all available servers
  static const allServers = [
    // NTP Pool Project (non-profit) first
    pool0,
    pool1,
    pool2,
    pool3,
    // NIST (non-profit)
    nist1,
    nist2,
    nist3,
    // Cloudflare
    cloudflare,
    // Google
    google,
    google1,
    google2,
    google3,
    google4,
  ];
}
