From: "C.Newport" <crn@netunix.com>
Date: Thu, 01 Jan 2004 00:54:50 +0000
Subject: Re: socal
Message-Id: <200401010054.50573.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 December 2003 11:57 pm, Aaron Wirtz wrote:

> I have a high suspicion that the reason the current drivers don't work may
> not be the version of the drivers, but the version of the ucode that I am
> trying to use with them.  If the ucode I am using implememnts an API other
> than what whe driver expects, that might be the issue.

The fcode and ucode will not have changed significantly.
I would rather suspect that the drivers have not been updated to
keep up with the 2.4.x kernel changes.
drivers/fc4/socal.c was last updated in Feb 1999 which puts it
back in 2.2.x land somewhere.

There are also problems with soc.c in 2.4.x but I have not looked
at this because my SS1000E has other issues with 2.4 anyway
so it is still on 2.2.20

BTW, Pete, is there any chance that the sun4d issues might come
to the top of the todo list sometime ?.
It would be nice to get these boatanchors working, especially in
view of Solaris 8 being the last supported release for them.

