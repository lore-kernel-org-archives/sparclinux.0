From: David Miller <davem@davemloft.net>
Date: Thu, 02 Aug 2012 07:27:59 +0000
Subject: Re: [PATCH v2] sparc64: do not clobber personality flags in sys_sparc64_personality()
Message-Id: <20120802.002759.225229908260811459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.00.1208012204140.14910@pobox.suse.cz>
	<alpine.LNX.2.00.1208020912130.14910@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1208020912130.14910@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jkosina@suse.cz
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 2 Aug 2012 09:12:46 +0200 (CEST)

> From 4f000eda5917ceecb03767962026cc6a390b8216 Mon Sep 17 00:00:00 2001
> From: Jiri Kosina <jkosina@suse.cz>
> Date: Wed, 1 Aug 2012 21:10:51 +0200
> Subject: [PATCH 4/4] sparc64: do not clobber personality flags in sys_sparc64_personality()
> 
> There are multiple errors in how sys_sparc64_personality() handles
> personality flags stored in top three bytes.
> 
> - directly comparing current->personality against PER_LINUX32 doesn't work
>   in cases when any of the personality flags stored in the top three bytes
>   are used.
> - directly forcefully setting personality to PER_LINUX32 or PER_LINUX
>   discards any flags stored in the top three bytes
> 
> Fix the first one by properly using personality() macro to compare only
> PER_MASK bytes.
> Fix the second one by setting only the bits that should be set, instead of
> overwriting the whole value.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Applied, thanks a lot Jiri.
