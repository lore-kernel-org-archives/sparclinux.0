From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 23 Nov 2012 23:55:44 +0000
Subject: Re: [PATCH] of/address: sparc: Declare of_iomap as an extern function for sparc again
Message-Id: <20121123235544.GA1407@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1353669849-23697-1-git-send-email-andreas@gaisler.com>
 <20121123.142110.835354734152648777.davem@davemloft.net>
 <20121123215947.02DDC3E1EC4@localhost>
 <61dbc2ab-5fa4-4095-bbba-11f146ad89a5@email.android.com>
In-Reply-To: <61dbc2ab-5fa4-4095-bbba-11f146ad89a5@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Miller <davem@davemloft.net>, andreas@gaisler.com, sam@ravnborg.org, rob.herring@calxeda.com, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, software@gaisler.com, stable <stable@vger.kernel.org>

On Fri, Nov 23, 2012 at 11:34:20PM +0000, Grant Likely wrote:
> Cc'ing stable since this should go into previous kernels too.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
