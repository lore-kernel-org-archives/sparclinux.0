From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 00:10:31 +0000
Subject: Re: srmmu: out of nocache
Message-Id: <20040329001031.GA17626@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200403282153.19509.lists@naasa.net>
In-Reply-To: <200403282153.19509.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 28, 2004 at 09:53:19PM +0200, lists@naasa.net wrote:

> I have an old SS5 with 128 MB memory. Sometimes, the kernel seems to have some 
> memory problems:
> Mar 24 07:03:05 ferdi kernel: bitmap out: size 8800 used 6242 off 1248 len 16 
> align 16 count 8816
> Mar 24 07:03:05 ferdi kernel: srmmu: out of nocache 4096: 2252800/1597952
> Mar 24 07:03:05 ferdi kernel: VM: killing process sendmail

You didn't even say what kernel version you use.  This was fairly
common in early 2.6; I haven't had any reports of it since 2.6.4 or
so.

-- 
Keith M Wesolowski
