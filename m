From: David Miller <davem@davemloft.net>
Date: Wed, 14 Nov 2012 22:33:04 +0000
Subject: Re: [PATCH] drivers/of: Constify device_node->name and ->path_component_name
Message-Id: <20121114.173304.405703188822325414.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1352932107-14782-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1352932107-14782-1-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, benh@kernel.crashing.org


You're making other changes here, such as the kstrdup() stuff,
seperate that into another patch.
