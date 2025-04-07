Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2323AE8B;
	Mon,  7 Apr 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024029; cv=none; b=QscDnI/WS+Vawhik1kbUWJ1XRcf0mbtI0aoVsH6Bg/28eHAQS+iR+S9m3l9NF/4PNV6/3OOu6TFBtIVXivLyYWzu5B4I50HvAaZHnvA+x1H0Qh8TACtJnHBQdJfDdpHoKFSKjyy0PSdhenuwZgDo4QcA1Eo2Wo7TkFRSZ4ah6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024029; c=relaxed/simple;
	bh=0IbVJLPXQykXsMAb/F7X9M2oU1sB9av0JzqfG+Rxc5A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bFCu7v8OqkRqwdVRZYVruhPSG63izT9RAv8ShgnuCufPlejjjFTR5ZyPfE9Q9u5ndh1bDOUoqwgECPx4792TfKQjja8vxXcg2dn3PgV2CTbE/xKMKLuhkI1Mkv5SaE+jWmR1MNEwpN6lKMtFlX61x5olkHSDzJQ9rU09hugvzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDKNp6ic; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDKNp6ic"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso27082285e9.2;
        Mon, 07 Apr 2025 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024025; x=1744628825; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4MosKBAgMVjw4i+o5gPRutczhd3YTCBKI2mgNnWVI4=;
        b=hDKNp6icUkhYWR8ImVNrf1t3sIvVCGO3Ul//Fz3NOjaGNYK7tw4i0Cwlsiv8bRVL9w
         XunodMywgbjSWLjlRKZF90CekUpvdrjueqcmqg17m12PvfoNkXykJr3yRLbk3KB/+7iL
         i57ZdLemvajl897p1sL2+WOfX90gf4oOSX18G7uSNnw0TQHdjKq8IeGCKkscrPIMj28M
         oCdlDUGhJOWMQfOrh+1j3BE5lia2yQuh5/BLv8KdiOoqeOb8fybhOzUXZqsxNbdryyql
         3SdfSRm7sDyEC0aBiF4AciGZWPj6L04l0SC8NSZHqZFqz9dXtpg0KTjoHjbgCma3JPVc
         X0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024025; x=1744628825;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4MosKBAgMVjw4i+o5gPRutczhd3YTCBKI2mgNnWVI4=;
        b=TV1fzCH145Kuyj9FwSa/gdyaxGoQVKDFNH5sqPUnpivyA7p8CX5mbITKBfJJ/NLYPz
         db4IkIJM+1wKEfJkQo/Uh6EtFWtRky6XK6uQg+w/o7Tut+Z7HO7WL1DbTrWwH8G7ZysX
         qF/jO1GNLsuRsug1liHTc7qgOiKkAF9Of40VaTHZSFDV61ODscZPwIo0vZKtVVf75n1d
         XscN0RGmWHRXgJ8L31VdCBkzf8s5X9EwoAEnP7nku2FW1fTlXibgEVsGT4UhhMX5GDwC
         CgR8tOyeYEFnHePfaFpChsFx49oLV641brjnUMd3TEqVBGkYHSHnAaQ16H1Q76m4he4C
         zUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCU+p4PBA5IF26eSM+X88V8H4gQ72nspyQBQIgSvIxJHbUv4fCEUzya/5yfUKIHDmq3FiRUK2mLlY5cA==@vger.kernel.org, AJvYcCXx8KW4WRRE9E8SE0zn5C5gW3aBNqffWgVwuvfyHpMLePnoBZWnVX5+5o1j/pp1PVgMNrWTbuNkg4KZHjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJJv37HKsquXR/bo16c9O9/WhvC7hvMG85aV9M6TVoTSPngwO
	PNm51Ign4vjZ0By6UMjqcwBriJGk3JTgxeJhHpZCNkGgOQhoP2bf
X-Gm-Gg: ASbGncvQaTYZu0CzBobkSxtZGFIegsKRT5HZC9EAi9NaU79D2jZGY9pR0VSU4c+qVMN
	f1x4ChiBaKaDEiV3lBM76K43Wh1UCyqY2cE9+tIKU8SHM1FXBXRxi7vJkSXSh6+ZNpS4pVdIq7s
	BX4GR8b3ZBe6+Q734ed2hvmYK5pSzXWFwCdmHTPztqqUT+utOGsX1Mcw3gUGyvZcC8mo+bkDu8x
	y00m8BicexOqEtcqimSW9gLsUt41cDFjPOjkiJSV310tFqVHFfh4fHu5s+qdHXnQ7Ae9UU3YbcF
	LPOa7VWviYPaQwQ19ke2W+3xYO2EQ3MGKn4=
X-Google-Smtp-Source: AGHT+IGEbHaqbV08bWBP//htgYXkx2K6J03KYFBtUcURgvs+cygHYiQIWyajimgzViJ/ES0hAbNR7A==
X-Received: by 2002:a05:600c:1e23:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43ecf81c304mr109645795e9.5.1744024024356;
        Mon, 07 Apr 2025 04:07:04 -0700 (PDT)
Received: from pc ([196.235.56.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16f1a73sm129843215e9.24.2025.04.07.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:07:03 -0700 (PDT)
Date: Mon, 7 Apr 2025 12:06:58 +0100
From: Salah Triki <salah.triki@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] sparc: pci: Fix memory leak in pci_bus_slot_names()
Message-ID: <Z_Ox0qp7uuKNUo2U@pc>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

prop is a local pointer in pci_bus_slot_names(). It is initialized
by calling of_get_property() so the caller must free prop when done
using it.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 arch/sparc/kernel/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index ddac216a2aff..fa0da8f45723 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -971,6 +971,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 		mask &= ~this_bit;
 		i++;
 	}
+
+	kfree(prop);
 }
 
 static int __init of_pci_slot_init(void)
-- 
2.43.0

