From: Aaron Wirtz <awirtz@novapointe.com>
Date: Wed, 31 Dec 2003 23:57:20 +0000
Subject: Re: socal
Message-Id: <200312311557.20213.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 December 2003 15:43, Pete Zaitcev wrote:
> Versions are entirely immaterial. To fix the driver, you
> need to read the code and tinker with it. It's not that hard.
> But playing lego with components will get you nowhere,
> just forget about it.

I beg to differ.  Versions are very important (at least to me) here:  one of 
them worked, and I want to either use that version until the current one is 
fixed or see what has changed so that a have a place to start working on 
fixing whatever has broken since it last worked.
I have a high suspicion that the reason the current drivers don't work may not 
be the version of the drivers, but the version of the ucode that I am trying 
to use with them.  If the ucode I am using implememnts an API other than what 
whe driver expects, that might be the issue.

-Aaron Wirtz

