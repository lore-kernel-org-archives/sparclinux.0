From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:57:00 +0000
Subject: Re: [PATCH v2] sparc: Convert to using %pOFn instead of device_node.name
Message-Id: <20181007.225700.1617106649049959507.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
        <20180828154433.5693-6-robh@kernel.org>
In-Reply-To: <20180828154433.5693-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Aug 2018 10:44:32 -0500

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - snprint -> snprintf typo fix

Applied.
