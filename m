From: Andi Kleen <andi@firstfloor.org>
Date: Fri, 24 Aug 2007 20:39:23 +0000
Subject: Re: errno codes intertwined
Message-Id: <p738x80y8ec.fsf@bingen.suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
In-Reply-To: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org

Jan Engelhardt <jengelh@computergmbh.de> writes:
> 
> So I'm just asking: can I rely on the same errno across Linuxes?

No. The errnos were originally designed to be compatible
with the "native" Unix on that platform to make running
their binaries easier. On Sparc that would
be SunOS/Solaris.

-Andi
