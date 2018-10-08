From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:57:16 +0000
Subject: Re: [PATCH] sbus: Use of_get_child_by_name helper
Message-Id: <20181007.225716.378361494554016624.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180829200337.15352-1-robh@kernel.org>
In-Reply-To: <20180829200337.15352-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Aug 2018 15:03:37 -0500

> Use the of_get_child_by_name() helper instead of open coding searching
> for the '/options' node. This removes directly accessing the name
> pointer as well.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.
