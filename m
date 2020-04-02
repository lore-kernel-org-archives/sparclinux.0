From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 02 Apr 2020 15:04:24 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <816eb7b6-9d9a-fb08-161d-f58e370facfc@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/2/20 4:57 PM, Rolf Eike Beer wrote:
> This seems generally be an option, but noone has a clue of LDOM at the moment. 
> You way come to #gentoo-sparc on Freenode if you want to give a helping hand.

You can use LDOMs, if you use Oracle Linux, OpenBSD or Solaris in the primary domain.

To use any other Linux operating system as the primary domain, someone would have
to package ldoms [1] and ldomsmanager [2] and use Oracle's kernel patches for
primary domain support.

Adrian

> [1] https://oss.oracle.com/ol6/SRPMS-SPARC64/ldoms-1.0.0-1595.el6.src.rpm
> [2] https://oss.oracle.com/ol6/SRPMS-SPARC64/ldomsmanager-3.5.0.0-26.2373.1.el6.src.rpm

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
