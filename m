From: Pete Zaitcev <zaitcev@redhat.com>
Date: Wed, 31 Dec 2003 23:43:56 +0000
Subject: Re: socal
Message-Id: <20031231234356.GC2051@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 31, 2003 at 02:29:26PM -0800, Aaron Wirtz wrote:
> Does anyone know of a patch that fixes the broken socal/fcal drivers under 
> 2.4.x or, failing that, does anyone know what version of the linux kernel and 
> the Solaris microcode Jakub was using in the past (1999) when he had the 
> driver working?

Versions are entirely immaterial. To fix the driver, you
need to read the code and tinker with it. It's not that hard.
But playing lego with components will get you nowhere,
just forget about it.

-- Pete
