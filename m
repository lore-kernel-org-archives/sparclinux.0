From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 13 Apr 2010 21:57:29 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100413215728.GF5602@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 13, 2010 at 02:35:37PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Tue, 13 Apr 2010 21:45:07 +0200
> 
> > Heh yeah. The trace/trace_pipe in the main directory are basically
> > unusable there. Only per_cpu can make it :)
> 
> Does it delay for several seconds at the beginning when you 'cat' them
> just like it does for me?


May be the stall started before.

Enabling the tracer now gives me the same result:

echo function_graph > current_tracer

