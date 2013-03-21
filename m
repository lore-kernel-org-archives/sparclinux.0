From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 21 Mar 2013 09:43:57 +0000
Subject: Re: [PATCH v4] sparc,leon: support for GRPCI1 PCI host bridge controller
Message-Id: <514AD65D.70100@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1362503010-30788-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1362503010-30788-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/20/2013 07:41 PM, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 5 Mar 2013 21:00:23 +0100
>
>> On Tue, Mar 05, 2013 at 06:03:30PM +0100, Daniel Hellstrom wrote:
>>> Some of the GRPCI1 cores does not support detection of all PCI
>>> errors, the default is therefore limited PCI error handling.
>>> The property all_pci_errors my be set by the boot loader to
>>> enable interrupt on all PCI errors.
>>>
>>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Applied to sparc-next


Thank you for reviewing applying my patches,

Daniel
