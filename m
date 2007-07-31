From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 31 Jul 2007 09:37:00 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46AF02BC.4030608@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: gavin duley <gduley@une.edu.au>
> Date: Mon, 30 Jul 2007 09:45:12 +0000
> 
>> On Mon, Jul 30, 2007 at 02:22:35AM -0700, David Miller <davem@davemloft.net> wrote:
>>> From: gavin duley <gduley@une.edu.au>
>>> Date: Mon, 30 Jul 2007 09:16:53 +0000
>>>
>>>> My Sun box is a Sun Ultra 5 with just one processor: a TI UltraSparc
>>>> IIi (Sabre). From memory, it is 333MHz with 2MB cache.
>>> What exactly is your test case that fails?
>> The application that hangs on my machine is iceweasel. The machine is 
>> running Debian testing:
> 
> So I installed debian/testing on my ultra5, and ran iceweasel
> both remotely over SSH and locally under gnome desktop,
> I could get neither to hang.
> 
> Now, my ultra5 has a 270MHZ Ultra-IIi compared to your higher
> speed chip, but I'm thinking that the cpu type is a red herring.
> 
> I think you guys have something enabled or in use in your
> installations that I don't.
> 
> Do you happen to be using NIS, or NFS, or something unique like that?
> If you have some firewalling enabled, can you retest with it disabled?

	David,

	My U2 is a NIS and NFS client and iceape works fine. NIS and NFS server 
is on my U60 (and on this workstation, iceape hangs). All accounts on 
U60 are local.

	For information, my U60 runs in runlevel 3 :
Root rayleigh:[/etc/rc3.d] > ls
README               S20cupsys      S20smartmontools      S50wu-ftpd
S09wd_keepalive      S20dbus        S20snmpd              S89anacron
S10sysklogd          S20dbus-1      S20xfs                S89atd
S11klogd             S20greylist    S20xinetd             S89cron
S15bind9             S20jabber      S20xprint             S89watchdog
S16ssh               S20mailman     S21fam                S90apache
S17iproute2          S20makedev     S21hddtemp            S99fail2ban
S18portmap           S20mimedefang  S21sendmail           S99fetchmail
S19mysql             S20mplayer     S23ntp                S99rc.local
S19mysql-ndb-mgm     S20mysql-ndb   S25mdadm              S99rmnologin
S19nis               S20nfs-common  S25nfs-kernel-server  S99stop-bootlogd
S20clamav-daemon     S20QoS         S30gdm                S99udev-fixes
S20clamav-freshclam  S20saslauthd   S30iptables

	Regards,

	JKB
