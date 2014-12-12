From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 02:53:42 +0000
Subject: Re: [PATCH] sparc32,leon: Align ccall_info to prevent unaligned traps on crosscall
Message-Id: <20141211.215342.709080245552027724.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1417773328-10396-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1417773328-10396-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, software@gaisler.com

From: Andreas Larsson <andreas@gaisler.com>
Date: Fri,  5 Dec 2014 10:55:28 +0100

> It is being filled in using std in leon_cross_call.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
