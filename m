From: "David S. Miller" <davem@redhat.com>
Date: Sun, 22 Feb 2004 23:17:39 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222151739.7a96bd4e.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 22 Feb 2004 14:10:41 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Sun, Feb 22, 2004 at 01:51:16PM -0800, William Lee Irwin III wrote:
> > It hanged early (I can photograph the front LED's and make them
> > webabble if need be). Bootlog included as a MIME attachment. The
> > "Button XIR" is me typing in the reset string (less traumatic than
> > cutting the power via APC MasterSwitch). The way I captured the
> > output as early as I did before was with this patch:
> 
> I get the same tftpbooting your vmlinux run through elftoaout, this
> time with -p. Does elftoaout look like the culprit?

It very well might be, let me tool around with this and study your
logs over the next day or so, I have some other things I really want
to finish first.

Meanwhile you can pick one of your 10 disks to install on :)

Thanks Will.
