From: David Miller <davem@davemloft.net>
Date: Wed, 23 Jan 2013 20:50:41 +0000
Subject: Re: Kernel panic on FPU instruction without FPU present
Message-Id: <20130123.155041.1428461100275555997.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130123203325.1e330a9a@bever>
In-Reply-To: <20130123203325.1e330a9a@bever>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I don't think we're going to support chips that lack an FPU,
sorry.

You can't even run the simplest things like the python interpreter
without FPU support, the first thing it does during initialization
is do a floating point square root.
