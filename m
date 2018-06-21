From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 21 Jun 2018 11:32:04 +0000
Subject: Re: Status of LDOM support in Linux?
Message-Id: <76a423a6-c4e7-2a56-7200-54c56f5d8c54@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <e7718e52-da12-9b1b-118c-e6472bf9f24c@physik.fu-berlin.de>
In-Reply-To: <e7718e52-da12-9b1b-118c-e6472bf9f24c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Liam!

On 06/21/2018 01:13 PM, Liam Merwick wrote:
>> Can anyone of the people involved with the LDOM support in Linux give a quick
>> update what the current status of the patches is? If I understand correctly,
>> we're still missing some bits and pieces that need to be added to make Linux
>> able to run as the primary domain.
> 
> The ldmd daemon depends on two major missing pieces: a new vldc driver (which would allow the userland daemon communicate via LDC with the Hypervisor) and extensive changes to the domain services driver.
> I hope to get to the vldc driver part but haven't had time to tidy the code up into a format for submission.
> 
> In addition, a virtual disk server (vds) driver that would allow the control or service domain export disk services would be required.
> 

Thanks a lot for your quick reply!

This doesn't sound too bad. Looking forward to be able to try it out in the future!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
