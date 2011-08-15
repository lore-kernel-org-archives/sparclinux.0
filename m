From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 21:37:03 +0000
Subject: Re: [PATCH] sparc64: remove unnecessary macros from spinlock_64.h
Message-Id: <20110815.143703.755340393661399080.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041.32055.652850.148995@pilspetsen.it.uu.se>
In-Reply-To: <20041.32055.652850.148995@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 15 Aug 2011 22:10:31 +0200

> The sparc64 spinlock_64.h contains a number of operations defined
> first as static inline functions, and then as macros with the same
> names and parameters as the functions.  Maybe this was needed at
> some point in the past, but now nothing seems to depend on these
> macros (checked with a recursive grep looking for ifdefs on these
> names).  Other archs don't define these identity-macros.
> 
> So this patch deletes these unnecessary macros.
> 
> Compile-tested with sparc64_defconfig.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied.
