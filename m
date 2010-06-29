From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 02:45:51 +0000
Subject: [PATCH 4/5] of: define CONFIG_OF globally so architectures can
Message-Id: <20100629124551.06fe1015.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
In-Reply-To: <20100629123843.5f94d477.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, devicetree-discuss@lists.ozlabs.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/of/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 7cecc8f..1678dbc 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -1,3 +1,6 @@
+config OF
+	bool
+
 config OF_FLATTREE
 	bool
 	depends on OF
-- 
1.7.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
