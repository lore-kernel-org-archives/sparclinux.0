From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 08 Jun 2005 11:52:28 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <20050608115228.GE2264@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III declared on Tuesday 07 June 2005 10:24 pm:
>> It seems like we get further. I've seen similar oopsen in tty_wakeup
>> on shutdown but am not terribly surprised if it could strike us
>> earlier.

On Wed, Jun 08, 2005 at 12:29:15AM -0500, Patrick Finnegan wrote:
> I *consistently* get an oops in tty_wakeup on shutdown of my E3000 and my 
> new E6500, which is fairly annoying.
> Fortunately, I don't have to shut down the machine too often.
> Any ideas what's wrong?  I've got a log of the console, System.map and 
> the .config up at:
> http://ned.cc.purdue.edu/e3k-tty_wakeup/

Apart from "the tty layer is f***ed", not really. We should probably
take our findings to whoever's now working on the tty layer.


-- wli
