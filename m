From: David Miller <davem@davemloft.net>
Date: Mon, 25 Oct 2010 15:57:45 +0000
Subject: Re: [PATCH 1/3] sparc: don't #include asm/system.h in
Message-Id: <20101025.085745.193706566.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Oct 2010 00:52:36 +0900

> It seems that #include <asm/system.h> makes a circular dependency
> between kernel.h and bitmap.h which breaks allmodconfig build.
> Removing the line makes no change because jump_label.h doesn't
> need it actually AFAICS. Compile tested on sparc32 allmodconfig.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
