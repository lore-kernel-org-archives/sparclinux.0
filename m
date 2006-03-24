From: Chris Boot <bootc@bootc.net>
Date: Fri, 24 Mar 2006 18:45:45 +0000
Subject: USB PCI problems on Ultra 5
Message-Id: <44243E59.8070203@bootc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I've been trying to add a PCI USB card to a Sun Ultra 5 workstation, and
I'm not naving much luck. Basically, I see two behaviours when the
machine boots up:

1. The machine doesn't even reach PROM (screen remains black).
2. The machine boots fine, but ignores the USB card and one of the other
PCI cards (usually the one in PCI slot 3).

Has anyone seen this sort of behaviour, let alone solved it?

It's a PCI card based on a VIA VT6212L chip, and works fine in the few
x86 PCs that I tried it in.

Many thanks,
Chris

PS: I'm not subscribed so please CC me.

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

