From: Baurzhan Ismagulov <ibr@ata.cs.hun.edu.tr>
Date: Sat, 09 Jul 2005 20:24:03 +0000
Subject: Re: Flashing of an Ultra2?
Message-Id: <20050709202403.GA9326@radix50.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
In-Reply-To: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Ulrich,

On Sat, Jul 09, 2005 at 08:45:58PM +0200, Ulrich Teichert wrote:
> So, the binary in question is flash-update-Ultra2-09, or what?

Seems so, if you want the latest revision.


> Now, more questions: would it be possible to use the PROM flashing module
> from Linux?

I would try creating a partition with a ufs filesystem, copying the
binary to that filesystem and booting from that partition.


With kind regards,
Baurzhan.
