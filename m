From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 10 May 2006 07:15:08 +0000
Subject: Re: sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <Pine.LNX.4.63.0605092358180.9053@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20060505113514.GA28863@palantir8>
In-Reply-To: <20060505113514.GA28863@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, 9 May 2006, David S. Miller wrote:

> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Tue, 9 May 2006 22:27:22 +0100
>
>> Sadly, no. I can try to do some of the easier things, but fixing
>> something like the esp driver without the esp&dma datasheets is
>> beyond me I'm afraid :).
>
> http://en.wikipedia.org/wiki/NCR_53C9x
>
> The DMA programming manual is really not that necessary to
> understand the chip.

I've poked at this issue a little bit, without diving too deep. I've=20
looked at the changes of the esp.c in the git kernel tree. There is one=20
fairly recent change on 2006-02-22 [0], earlier changes are at least a=20
year old. The diff for that commit is the following:

--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -2068,14 +2068,12 @@ static int esp_reset(struct scsi_cmnd *S
  {
  	struct esp *esp =3D (struct esp *) SCptr->device->host->hostdata;

+	spin_lock_irq(esp->ehost->host_lock);
  	(void) esp_do_resetbus(esp);
-
  	spin_unlock_irq(esp->ehost->host_lock);

  	wait_event(esp->reset_queue, (esp->resetting_bus =3D 0));

-	spin_lock_irq(esp->ehost->host_lock);
-
  	return SUCCESS;
  }

I have not nearly enough knowledge to tell whether that is correct, but=20
the fact that in the previous version the function is left with the lock=20
held and in the new one - without it, struck me as suspicious. I've tried=20
reverting this change and the 2.6.16 kernel started working much more=20
reliably for me, I haven't seen a DMA error with it yet. Unfortunately,=20
other people who tested it (including Martin) reported that reverting this =

patch (or including it, if it was not present in the kernel) had little or =

no effect. Dave, it would be great that if you could confirm that this=20
patch actually does what it's supposed to do, that would be a significant=20
indication that the problem is not in esp.c.

I've recently built 2.6.16 and 2.6.17-rc3 kernels with Debian's gcc=20
4.0.3-2, and they boot. Modules load fine. There is some kind of issue=20
with the network, loading sunlance on my SS20 does not work every time. I=20
haven't had a chance to investigate it in detail yet. Martin, you can=20
fetch the "most stable for me" 2.6.16 kernel from [1].

[0] http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=A6ceda7457b2303dcb07d3c472b25d52bbdb5a29
[1] http://www.wooyd.org/debian/kernels

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
