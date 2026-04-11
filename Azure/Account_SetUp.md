
# ☁️ Microsoft Azure — Free Tier Account Setup Notes

## 1. What is Microsoft Azure?

**Microsoft Azure** is a **cloud computing platform** owned and operated by Microsoft. It provides a wide range of cloud services including:

- 💻 **Compute** — Virtual Machines, App Services
- 🗄️ **Storage** — Blob Storage, File Storage, Databases
- 🌐 **Networking** — Virtual Networks, Load Balancers, DNS
- 🤖 **AI & ML** — Azure OpenAI, Cognitive Services
- 🔐 **Security** — Azure Active Directory, Key Vault
- 📊 **Analytics** — Azure Synapse, Data Factory

Azure competes with **AWS (Amazon)** and **GCP (Google Cloud)** as one of the top 3 cloud providers in the world.

---
## 2. What is the Azure Free Tier?

Azure offers a **Free Account** that includes:

| Offer Type | Details |
|---|---|
| 💰 Free Credit | **$200 USD** credit valid for **30 days** |
| 🕐 Always Free Services | 55+ services free forever (with limits) |
| 📅 12-Month Free Services | Popular services free for the **first 12 months** |

> ⚠️ **Note:** After 30 days or once $200 credit is used up, you will only have access to "Always Free" services unless you upgrade to Pay-As-You-Go.

---

## 3. Prerequisites

Before creating your Azure account, make sure you have:

- [x] A valid **Email Address** (Microsoft/Outlook account preferred, but any email works)
- [x] A **Phone Number** (for identity verification via OTP)
- [x] A valid **Credit/Debit Card** (for identity verification — you will NOT be charged)
- [x] A stable **Internet Connection**
- [x] A modern **web browser** (Chrome, Edge, Firefox recommended)

> 💡 **Tip:** You can also use a **virtual/prepaid card** for verification, but some may not be accepted. A standard Visa/Mastercard debit card works best.

---

## 4. Step-by-Step: Creating Your Azure Free Account

### 🔗 Step 1 — Go to the Azure Free Account Page

Visit: **[https://azure.microsoft.com/en-us/free](https://azure.microsoft.com/en-us/free)**

Click the green **"Start free"** button on the homepage.

---

### 👤 Step 2 — Sign In or Create a Microsoft Account

You will be redirected to the Microsoft login page.

**Option A — You already have a Microsoft account:**
- Enter your existing email (Outlook, Hotmail, Live, etc.)
- Enter your password
- Click **Sign In**

**Option B — You don't have a Microsoft account:**
- Click **"Create one!"**
- Enter a new email address OR use an existing email (Gmail also works)
- Set a strong password
- Complete the CAPTCHA
- Verify email via the OTP sent to your inbox

---

### 📝 Step 3 — Fill in Your Profile Details

After signing in, you'll be taken to the Azure Free Account registration form.

Fill in the following:

```
Country/Region     → Select your country (e.g., India)
First Name         → Your first name
Last Name          → Your last name
Email Address      → Auto-filled from your Microsoft account
Phone Number       → Enter mobile number for OTP verification
```

Click **"Text me"** or **"Call me"** to receive your verification OTP.

Enter the OTP and click **Verify**.

---

### 💳 Step 4 — Credit/Debit Card Verification

This step is for **identity verification only** — Microsoft will NOT charge you.

```
Card Number        → 16-digit card number
Expiry Date        → MM/YY
CVV                → 3-digit security code
Name on Card       → As printed on card
Billing Address    → Your address
```

> ⚠️ Azure may place a **temporary hold of ₹2 or $1** on your card just to verify it is valid. This is **reversed automatically** within a few days.

Click **Next** after entering card details.

---

### ✅ Step 5 — Agree to Terms & Submit

- Read the **Subscription Agreement**, **Offer Details**, and **Privacy Statement**
- Check the box: *"I agree to the subscription agreement, offer details, and privacy statement"*
- Click **"Sign up"**

Azure will take a few seconds to set up your account.

---

### 🎉 Step 6 — Account Created!

You'll see a **"You're ready to start with Azure"** screen.

Click **"Go to the Azure portal"** — This takes you to **[https://portal.azure.com](https://portal.azure.com)**

---

## 5. Azure Portal Overview

The **Azure Portal** is your main dashboard to manage all Azure services.

```
┌─────────────────────────────────────────────────────────┐
│  🔷 Microsoft Azure                         [Your Name] │
├─────────────────────────────────────────────────────────┤
│  🏠 Home   📊 Dashboard   🔧 All Services              │
├──────────────┬──────────────────────────────────────────┤
│              │                                          │
│  Navigation  │         Main Content Area                │
│  Panel       │         (Resources, Services)            │
│              │                                          │
│  + Create    │                                          │
│  Resource    │                                          │
│              │                                          │
└──────────────┴──────────────────────────────────────────┘
```

### Key Areas of the Portal:

| Area | Description |
|------|-------------|
| **Home** | Quick access to recent resources and services |
| **Resource Groups** | Logical containers to organize your resources |
| **Subscriptions** | Your billing account (Free Trial shown here) |
| **All Services** | Browse all 200+ Azure services |
| **Cost Management** | Monitor your spending and credits |
| **Azure Active Directory** | User and identity management |
| **Cloud Shell** | Built-in terminal (Bash/PowerShell) in the browser |

---

## 6. Free Services Included

### 🕐 Always Free (No Expiry)

| Service | Free Limit |
|---------|-----------|
| Azure App Service | 10 web apps |
| Azure Functions | 1 million requests/month |
| Azure Cosmos DB | 1,000 RU/s throughput, 25 GB storage |
| Azure SQL Database | 32 GB storage (Basic tier) |
| Azure Blob Storage | 5 GB locally redundant storage |
| Azure DevOps | 5 users, unlimited private repos |
| Azure Static Web Apps | 100 GB bandwidth/month |
| Azure Monitor | Basic metrics & logs |
| Azure Key Vault | 10,000 transactions/month |

### 📅 Free for 12 Months (From Account Creation Date)

| Service | Free Limit |
|---------|-----------|
| Linux Virtual Machine (B1s) | 750 hours/month |
| Windows Virtual Machine (B1s) | 750 hours/month |
| Azure SQL Database | 250 GB storage/month |
| Azure Blob Storage | 5 GB + 2 million read ops |
| Azure Files | 100 GB storage |
| Azure Bandwidth | 15 GB outbound transfer |
| Azure Container Registry | 1 standard registry |

---

## 7. Important Concepts to Know

### 🔑 Subscription
Your **Subscription** is the billing unit in Azure. Everything you create belongs to a subscription. Your free account gets a **"Free Trial"** subscription.

### 📁 Resource Group
A **Resource Group** is a logical container (like a folder) to organize Azure resources. Best practice: group related resources together (e.g., all resources for one project).

```
Subscription: Free Trial
└── Resource Group: MyFirstApp-RG
    ├── Virtual Machine: myVM
    ├── Storage Account: mystorage123
    └── Virtual Network: myVNet
```

### 🌍 Region
Azure has **data centers** around the world called **Regions**. When creating a resource, you pick a region (e.g., East US, Central India, Southeast Asia). Choose the region **closest to your users** for best performance.

### 🏷️ Resource
Any service you create on Azure (VM, database, storage, etc.) is called a **Resource**.

### 💰 Azure Free Credits ($200)
- Valid for **30 days** from signup date
- Can be used on ANY Azure service (including paid ones)
- Once $200 is exhausted OR 30 days pass (whichever comes first), free trial services are restricted

---

## 8. Billing & Cost Management

### How to Check Your Remaining Credits:

1. Go to **[https://portal.azure.com](https://portal.azure.com)**
2. Search for **"Cost Management + Billing"** in the top search bar
3. Click on **"Subscriptions"** → Select **"Free Trial"**
4. You'll see your remaining **$200 credit** and usage details

### Setting Up Budget Alerts:

1. Go to **Cost Management + Billing**
2. Click **"Budgets"** → **"+ Add"**
3. Set amount (e.g., $10) and configure email alerts at 80% and 100% usage

> 💡 **Pro Tip:** Set a budget alert at even $1 so you get notified the moment any charges begin.

---

## 9. Tips to Avoid Accidental Charges

> ⚠️ These are the most important tips for beginners!

1. **Always use Free Tier services** — Check the pricing page before creating any resource
2. **Delete resources when done** — Idle resources (especially VMs) still incur charges
3. **Set spending alerts** — Use Cost Management to set budget alerts
4. **Use resource groups** — Delete entire resource groups to ensure nothing is left running
5. **Check VM size** — Only `B1s` size is free; larger sizes will charge immediately
6. **Avoid Premium Storage** — Use Standard HDD, not Premium SSD for free usage
7. **Stop (not just pause) VMs** — A VM must be in **"Stopped (Deallocated)"** state to stop billing
8. **Watch your 12-month clock** — Calendar reminder for when your 12 months end

---

## 10. Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| "Card declined" | Virtual/prepaid card not accepted | Use a standard Visa/Mastercard debit card |
| "Phone number already used" | Number tied to existing Azure account | Use a different phone number |
| "Email already has an Azure account" | Email linked to old/existing account | Use a different email address |
| "OTP not received" | Network/SMS delay | Wait 60 seconds and click "Resend OTP" |
| "Region not available" | Some regions have restrictions | Try a different region (e.g., East US instead of Central India) |
| Portal not loading | Browser cache issue | Clear cache or try Incognito/Private mode |

---

## 11. Next Steps After Account Creation

Now that your account is set up, here's what to explore next:


## 📌 Key URLs to Bookmark

| URL | Purpose |
|-----|---------|
| `portal.azure.com` | Main Azure Portal |
| `azure.microsoft.com/free` | Azure Free Account signup |
| `learn.microsoft.com` | Official Microsoft Learning |
| `azure.microsoft.com/pricing` | Azure Pricing Calculator |
| `status.azure.com` | Azure Service Health Status |

---

---

*Happy Learning! ☁️ The cloud journey has just begun!*
