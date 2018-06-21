From: Liam Merwick <liam.merwick@oracle.com>
Date: Thu, 21 Jun 2018 11:13:33 +0000
Subject: Re: Status of LDOM support in Linux?
Message-Id: <a33ac039-1ec8-58c2-475a-f26b7e067b6c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e7718e52-da12-9b1b-118c-e6472bf9f24c@physik.fu-berlin.de>
In-Reply-To: <e7718e52-da12-9b1b-118c-e6472bf9f24c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 21/06/2018 11:37, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> Can anyone of the people involved with the LDOM support in Linux give a quick
> update what the current status of the patches is? If I understand correctly,
> we're still missing some bits and pieces that need to be added to make Linux
> able to run as the primary domain.

The ldmd daemon depends on two major missing pieces: a new vldc driver 
(which would allow the userland daemon communicate via LDC with the 
Hypervisor) and extensive changes to the domain services driver.
I hope to get to the vldc driver part but haven't had time to tidy the 
code up into a format for submission.

In addition, a virtual disk server (vds) driver that would allow the 
control or service domain export disk services would be required.

Regards,
Liam
