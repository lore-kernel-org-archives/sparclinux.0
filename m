From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 18:44:03 +0000
Subject: Re: [RFC PATCH 02/15] dt: add a match table pointer to struct
Message-Id: <20110223184402.GM14597@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
 <20110223043345.20795.2936.stgit@localhost6.localdomain6>
 <4D6551EF.70207@gmail.com>
In-Reply-To: <4D6551EF.70207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Wed, Feb 23, 2011 at 12:29:03PM -0600, Rob Herring wrote:
> Grant,
> 
> On 02/22/2011 10:33 PM, Grant Likely wrote:
> >Add a new .of_match field to struct device which points at the
> >matching device driver .of_match_table entry when a device is probed
> >via the device tree
> >
> >Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> >---
> >  include/linux/device.h    |    1 +
> >  include/linux/of_device.h |    5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/device.h b/include/linux/device.h
> >index ca5d252..8d8e267 100644
> >--- a/include/linux/device.h
> >+++ b/include/linux/device.h
> >@@ -441,6 +441,7 @@ struct device {
> >  	struct dev_archdata	archdata;
> >
> >  	struct device_node	*of_node; /* associated device tree node */
> >+	const struct of_device_id *of_match; /* matching of_device_id from driver */
> 
> Couldn't of_match/of_match_table be merged into the platform dev/drv
> id_entry/id_table. Handling MODALIAS for a driver that does both OF
> style and normal platform device matching may be a problem though.

.of_match & .of_match_table works on all devices, not just
platform devices.  It allows the common library of device tree support
routines to be used with any bus type.

g.

