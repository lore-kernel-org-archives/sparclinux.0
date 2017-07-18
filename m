From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2017 21:51:53 +0000
Subject: Re: [PATCH] sbus: Convert to using %pOF instead of full_name
Message-Id: <20170718.145153.1446387361078073279.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170718214339.7774-47-robh@kernel.org>
In-Reply-To: <20170718214339.7774-47-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 16:43:27 -0500

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
