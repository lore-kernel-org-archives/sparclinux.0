From: Leif Sawyer <lsawyer@gci.com>
Date: Wed, 07 Oct 2009 22:20:10 +0000
Subject: RE: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <18B2C6E38A3A324986B392B2D18ABC5102B90E@fnb1mbx01.gci.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Mitch Bradley writes:
> Taking this one step further, I don't see any real good
> reason to continue supporting Sun4 going forward.  I got rid
> of my Sun4 systems long ago because it was just too hard to
> keep them working - after having used them long after most
> people had moved on.

I've got a few sun4u machines that are going strong.  I'd
hate to see support "go away" going forward.

I do wish I knew more about the archetecture and kernel development,
but alas, my life conspires against me when I try to learn more.

I do know that this release seems to be the latest version that I can cleanly
boot without much issue:

Linux wormhole 2.6.25-gentoo-r2 #2 SMP PREEMPT Tue May 6 20:59:30 AKDT 2008 sparc64 sun4u TI UltraSparc II (BlackBird) GNU/Linux

I do try to send bug reports/comments to the various lists, and watch the development.
Unfortunately, none of my systems are available for "lab" work, as they're all remotely deployed,
so testing of new kernels can really only happen when I have somebody available onsite
to remotely powercycle, as the crashes tend to be severe enough that I can't break-to-OBP

But thanks for all the hard work.

Leif
