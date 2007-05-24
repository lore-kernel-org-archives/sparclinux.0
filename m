From: David Miller <davem@davemloft.net>
Date: Thu, 24 May 2007 07:35:28 +0000
Subject: Re: [PATCH]: Better serial console identification
Message-Id: <20070524.003528.104052359.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070520.140354.92582888.davem@davemloft.net>
In-Reply-To: <20070520.140354.92582888.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 23 May 2007 16:56:59 -0500

> On Wed, 2007-05-23 at 14:27 -0700, David Miller wrote:
> > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > Date: Wed, 23 May 2007 14:04:02 -0500
> > 
> > > Just for kicks, I tried passing esp_bus_reset_settle, but it doesn't
> > > change the result at all.
> > > 
> > > I also grabbed a log with esp_debug 47, that log is attached.
> > 
> > Does this fix the problem?
> 
> Nope. No change. Do you want the esp_debug 47 from that?

Tom, can you double check that you ran with my fix applied?
I'm not doubting you, I'll explain why I'm asking this, and
your hunch to mess around with esp_bus_reset_settle was a
good one.

The disk is returning the following sense code:

sshdr->response_code = 0x70;
sshdr->sense_key = 0x06;
sb_len = 18;
sshdr->asc = 0x29;
sshdr->ascq = 0x02;

This means UNIT_ATTENTION with 0x29+0x02 supplemental status.

The UNIT_ATTENTION is fine, but the supplemental status is the kind a
device gives if you try to talk to it too soon after a reset.

Therefore what I am sure is happening is that the ssleep() in
scsi_esp_register() is not waiting long enough, and in fact I think
it's returning immediately.

This would be consistent with a corrupted value of the 'current' task
register which is exactly what my patch would fix.

I went over this serial console change and your trace a few times
and I think it's worth double checking :-)
