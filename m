From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 09 Sep 2004 17:19:35 +0000
Subject: Re: Sun4D SMP now works OK, serial console broken - was Re: More Sun4d tests
Message-Id: <20040909171935.GV3106@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200409091646.21205.crn@netunix.com>
In-Reply-To: <200409091646.21205.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 9 Sep 2004, C.Newport wrote:
>> My SS1000E seems to be stable with 2.4.27 after fitting a frame
>> buffer and keyboard. It rebuilds a kernel OK in SMP mode.
>> Serial console is still broken, there seems to be a problem
>> with the sunzilog driver.
>> What other Sun machines use sunzilog.c as the serial console ?.
>> Is this problem really a sun4d issue or is it generic to sunzilog ?

On Thu, Sep 09, 2004 at 12:55:19PM -0400, Chris Ricker wrote:
> I think early Ultras (Ultra2, for example) are Sun Zilog as well. I've not 
> tried serial console on mine in a while though....

Yes, SunZilog appears to be stable on all my UltraSPARC machines. The
bug is likely something specific to older revisions typically used in
sun4d boxen or some such.


-- wli
