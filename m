From: David Miller <davem@davemloft.net>
Date: Mon, 19 Mar 2018 23:33:41 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180319.193341.105600714432834778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
        <20180319.142831.793002554436316260.davem@davemloft.net>
        <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, yinghai@kernel.org, linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj, airlied@linux.ie, dri-devel@lists.freedesktop.org, alex.williamson@redhat.com

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Mar 2018 14:38:54 -0500

> I'd be happy to remove both.  But I wonder how X init works on
> sparc.

It's been many years since I worked on this, but I think it
mapped and used the PCI ROM resource for this.
