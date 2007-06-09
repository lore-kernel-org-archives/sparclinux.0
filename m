From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 09 Jun 2007 17:49:08 +0000
Subject: Strange trouble with clamd/greylist/mimedefang
Message-Id: <466AE814.8010605@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I use two UltraSparc workstations, the first one is an U80 named kant 
(4*UII@450), the other one is an U60 named rayleigh (2*UII@450). kant is 
a MX1 mail server that runs on debian testing sendmail, milter-greylist, 
mimedefang  with spamassassin and clamd. rayleigh is MX2.

	On rayleigh, clamd and milter-greylist work fine. Some clamd process 
and milter-greylist run at the same time, and this MX2 work.

rayleigh:[~] > ps auwx | grep milter
bertrand  3803  0.0  0.0   3520   976 pts/3    S+   19:36   0:00 grep milter
root     23781  0.0  2.4  52144 24872 ?        Ss   Jun08   0:00 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
root     23782  0.0  2.4  52144 24872 ?        S    Jun08   0:00 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
root     23783  0.0  2.4  52144 24872 ?        S    Jun08   0:51 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
root     23784  0.0  2.4  52144 24872 ?        S    Jun08   0:00 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
root     23785  0.0  2.4  52144 24872 ?        S    Jun08   0:00 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
rayleigh:[~] > ps auwx | grep clamd
bertrand  3824  0.0  0.0   3520   976 pts/3    S+   19:37   0:00 grep clamd
clamav   25331  1.0  7.6  86896 79376 ?        Ss   15:19   2:39 
/usr/sbin/clamd
clamav   26113  0.0  7.6  86896 79376 ?        S    15:34   0:00 
/usr/sbin/clamd
rayleigh:[~] >

	With exactly the _same_ configuration, only one milter-greylist and one 
clamd process run on kant !

kant:[~] > ps auwx | grep milter
root      9973  0.0  0.1  69968  2600 ?        Ssl  19:16   0:00 
/usr/local/bin/milter-greylist -P /var/run/greylist.pid -u root -p 
/var/run/milter-greylist/greylist.sock
bertrand 12436  0.0  0.0   3800  1024 pts/1    S+   19:37   0:00 grep milter
kant:[~] > ps auwx | grep clamd
clamav    5639  2.9  2.0  65936 42448 ?        Ssl  19:06   0:55 
/usr/sbin/clamd
bertrand 12467  0.0  0.0   3800  1024 pts/1    S+   19:37   0:00 grep clamd
kant:[~] >

	Some inbound mails are refused by kant (because clamd cannot scan all 
inbound mails). They remain in sendmail DATA stage and SMTP transaction 
aborts due to a timeout. I don't understand why with the same 
configuration, MX1 does not works. I'm sure that clamd works fine on 
rayleigh, but I'm not sure that it correctly works on kant. I don't see 
any information on the logs and all sockets and permissions have been 
verified. If I remove clamd support from mimedefang, kant works fine. I 
don't understant why only one clamd process can run on kant.

	Kernel is 2.6.20.11 (with netfilter ROUTE patch) from kernel.org.

	Both run debian/testing. Kant is up to date. Last upgrade was made on 
rayleigh 8 days ago.

	Any idea ?

	Regards,

	JKB
