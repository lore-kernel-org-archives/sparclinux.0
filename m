From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 24 Nov 2019 09:44:36 +0000
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
Message-Id: <e91984fa-3544-8b7e-d577-54125b075fbe@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191124085720.6201-1-rppt@kernel.org>
In-Reply-To: <20191124085720.6201-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>

Hi!

On 11/24/19 9:57 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and replace 5leve-fixup.h with pgtable-nop4d.h.                                      ^^^^^ typo?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
