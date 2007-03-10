From: David Miller <davem@davemloft.net>
Date: Sat, 10 Mar 2007 08:28:22 +0000
Subject: Re: [PATCH] Fix atomicity of TIF update in flush_thread() for
Message-Id: <20070310.002822.106265002.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070310080844.GA23144@Krystal>
In-Reply-To: <20070310080844.GA23144@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: compudj@krystal.dyndns.org
Cc: akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Date: Sat, 10 Mar 2007 03:08:44 -0500

> Fix atomicity of TIF update in flush_thread() for sparc64

Applied, thanks for fixing this up.
