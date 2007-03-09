From: David Miller <davem@davemloft.net>
Date: Fri, 09 Mar 2007 05:24:33 +0000
Subject: Re: [PATCH] Fix atomicity of TIF update in flush_thread() for
Message-Id: <20070308.212433.122615911.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070309023814.GA9462@Krystal>
In-Reply-To: <20070309023814.GA9462@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@polymtl.ca
Cc: akpm@linux-foundation.org, mbligh@google.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Thu, 8 Mar 2007 21:38:14 -0500

> Fix atomicity of TIF update in flush_thread() for x86_64
                                                    ^^^^^^
You mean sparc64 of course, I fixed this up while committing your
patch, thanks a lot.
