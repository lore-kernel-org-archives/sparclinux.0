From: David Miller <davem@davemloft.net>
Date: Wed, 28 Mar 2012 01:33:19 +0000
Subject: Re: v440 & expert 3D
Message-Id: <20120327.213319.2232645140601942875.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1332502667.1755.10.camel@deblnxsrv224.lan>
In-Reply-To: <1332502667.1755.10.camel@deblnxsrv224.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Frans van Berckel" <fberckel@xs4all.nl>
Date: Wed, 28 Mar 2012 02:29:44 +0200

> [  201.695856] e3d: Found device at 0002:00:03.0
> 
> SC Alert: Host System has Reset
> 
> SC Alert: Failed to send email alert for recent event.

The kernel takes a hard fault trying to program the graphics
chip registers.
