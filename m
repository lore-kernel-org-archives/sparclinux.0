From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jun 2008 06:01:04 +0000
Subject: Re: disks on Ultra/1 not detected with esp_scsi on 2.6.24
Message-Id: <20080617.230104.126401406.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080412093242.GP3535@bayworld.net>
In-Reply-To: <20080412093242.GP3535@bayworld.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nick Schmalenberger <nick@schmalenberger.us>
Date: Sat, 12 Apr 2008 02:32:42 -0700

> Full dmesg, hardware summary, and syslog are attached, thanks for all help!

The following looks suspicious:

Apr 12 07:11:58 hw-detect: Missing modules 'esp (ESP SCSI), usb-storage (USB storage)

The esp_scsi module seems to have been loaded, but the sun_esp module
did not.  This is probably what the problem is.


