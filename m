From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 14 Jan 2004 01:39:46 +0000
Subject: Re: Status of Ross hyperSPARC on linux-2.4.x and linux-2.6.x?
Message-Id: <20040114013946.GA6047@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040113204206.A988@sparky.j-son.org>
In-Reply-To: <20040113204206.A988@sparky.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 13, 2004 at 08:42:06PM +0100, christian@j-son.org wrote:

> Just a little ping for me (and anyone else).. what's the status of the
> linux kernels 2.4 and 2.6 for running Ross' hyperSPARC processors?

2.4 is more or less hosed.  I don't plan to fix it, no time.  2.6
boots UP and seems to work as well as SuperSPARC given the limited
testing I've done so far.  It may be possible later to backport
whatever changes are made in 2.6, but frankly I don't recommend to use
2.4.  If you want to help development, use 2.6.  If you need first
rate stability, use 2.2.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
