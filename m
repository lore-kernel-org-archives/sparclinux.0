From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 08 Jun 2005 05:29:15 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <200506080029.15204.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III declared on Tuesday 07 June 2005 10:24 pm:
> It seems like we get further. I've seen similar oopsen in tty_wakeup
> on shutdown but am not terribly surprised if it could strike us
> earlier.

I *consistently* get an oops in tty_wakeup on shutdown of my E3000 and my 
new E6500, which is fairly annoying.

Fortunately, I don't have to shut down the machine too often.

Any ideas what's wrong?  I've got a log of the console, System.map and 
the .config up at:

http://ned.cc.purdue.edu/e3k-tty_wakeup/

Pat
-- 
Purdue University ITAP/RCAC       --- http://www.rcac.purdue.edu/
The Computer Refuge               --- http://computer-refuge.org
