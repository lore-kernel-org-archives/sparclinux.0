From: Chris Ricker <kaboom@gatech.edu>
Date: Sat, 24 Jan 2004 14:46:37 +0000
Subject: Re: 2.6.2-rc1 smp crash
Message-Id: <Pine.GSO.4.58.0401240946000.13259@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123134628.GH27566@phunnypharm.org>
In-Reply-To: <20040123134628.GH27566@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 23 Jan 2004, Ben Collins wrote:

> Give the attached patch a try. Seems sunzilog was pulling down some
> spinlocks that the serial_core was already doing.

thanks much, it's been running since yesterday without problems

later,
chris
