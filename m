From: "David S. Miller" <davem@redhat.com>
Date: Sun, 22 Feb 2004 18:03:34 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222100334.1dde250e.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 22 Feb 2004 01:57:55 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> n Sat, Feb 21, 2004 at 11:25:33PM -0800, David S. Miller wrote:
> >> So, Will, did you test out the test kernel image I emailed to you the
> >> other day or did your spam filter eat it?
> 
> On Sun, Feb 22, 2004 at 01:11:50AM -0800, William Lee Irwin III wrote:
> > Unfortunately I never saw a test kernel image, so the spamfiltering bit
> > looks likely.
> 
> Make that "certain":

I put one up here instead:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/for_wli/

It may take a few minutes to propagate, but there'll be this there when it's
done:

-rw-r--r--    1 davem    ftpadmin   874502 Feb 22 10:02 System.map-2.6.3
-rwxr-xr-x    1 davem    ftpadmin  3615392 Feb 22 09:53 vmlinux-263

Let me know how it goes.
